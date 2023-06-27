# HomeAssistant - Home automation server

## HomeAssistant - VM configuration

- VM id: 104
- HDD:
  - don’t make any changes because it will be changed later with the Home Assistant QCOW2 installation file
- Sockets: 1
- Cores: 2
- RAM:
  - Min: 4084
  - Max: 4084
  - Ballooning Devices: enabled
- Machine: i440fx
- BIOS OVMF (UEFI)
- SCSI Controller: VirtIO SCSI
- Network
  - LAN MAC address: DE:5C:A6:B6:4A:AA
  - Static ip assigned in pfSense: 192.168.0.100
  - Local domain record in piHole: ha .local
- Options:
  - Start at boot: enabled
  - Start/Shutdown order: oder=6
- OS: [Home Assistant Operating System](https://www.home-assistant.io/installation/linux)

## HomeAssistant - Installation and setup

Download the QCOW2 image file from [Home Assistant Operating System](https://www.home-assistant.io/installation/linux) and upload it to Proxmox host via SSH in the `/root` home folder.

After the transfer completes, go back into the Proxmox web interface, click on the Proxmox server, and then Shell. To import the Home Assistant installation file to the VM that was created, enter the following command:

```bash
qm importdisk 104 /root/[hassos_file_name] local-lvm --format qcow2
```

When the import finishes, it should show that it was successfully imported as an unused disk.

```bash
Successfully imported disk as 'unused0:local-lvm:vm-104-disk-2'
```

Go back into the Home Assistant VM and then go into `Hardware`. The unused disk with the installation file would be at the bottom as `Unused Disk 0`. Click on the current active Hard Disk, `Hard Disk (scsi0)`, then click on `Detach`, and on the pop up click on `Yes`. That hard disk would then show up at the bottom as `unused disk 1`. Select that disk, then click on `Remove` and then click on `Yes`. Now, the `Unused Disk 0`, which is the one with the Home Assistant installation, double click it, and on the pop-up, click on Add.

The hard disk, by default, would only have 6GB available. So, to make it larger (32GB Recommended), click on `Resize disk` and add the additional amount that you want to add to the 6GB already available.

The configuration is now completed After powering on the Home Assistant VM, go into `Console` to verify that the installation is working as expected. The process can take several minutes. After the installation is finalized, go to `ha.local:8123`, and the Home Assistant initial configuration would come up.

## HomeAssistant - Other plugins

## HomeAssistant - Mosquitto broker(MQTT)

Open `Supervisor -> Add-on Store` and search for `Mosquitto broker` addon and install it.

Click `Mosquitto broker` and continue configuration there

- Info tab
  - Make sure `Start on boot`, `Watchdog` and `Auto update` options are active
- Configuration tab
  - add the following configuration

    ```yaml
    logins:
      - username: ha_mqtt
        password: HaMqttPass_123
    customize:
      active: false
      folder: mosquitto
    certfile: fullchain.pem
    keyfile: privkey.pem
    require_certificate: false
    ```

  - Normal MQTT TCP port - `1833`
  - MQTT over WebSocker port - `1884`
  - Normal MQTT with SSL port - `8883`
  - MQTT over WEbSocker with SSL - `8884`

Press the `Start`* button on the info page of the integration and check the `Log` section to make sure HomeAssistant connects succesfully to Paradox Alarm.

Add the following code in `configurations.yam`l file. Sensitive information is located in a separate file called `secrets.yaml`.

```yaml
# Configuration for connection to mqtt server on home server
mqtt:
  discovery: true
  discovery_prefix: homeassistant
  broker: !secret mqtt_host
  port: 1883
  client_id: home-assistant-1
  keepalive: 60
  username: !secret mqtt_username
  password: !secret mqtt_password
```

## HomeAssistant - Paradox Alarm integration

In order to communicated with Paradox Alarm you need the following preconditions:

- Pannels PC password
- IP150 connection connected to the Alarm interface
- Mosquitto broker addon installed and configured as described in section
[HomeAssistant - Mosquitto broker(MQTT)](#homeassistant---mosquitto-brokermqtt)
- Install an additional

Open `Supervisor -> Add-on Store` and click the three dots in the upper right corner. Select `Repositories` and add repository for `Paradox Alarm Interface Hass.io` from `https://github.com/ParadoxAlarmInterface/hassio-repository`

There should be 3 new integrations available in `Supervisor -> Add-on Store` section at the bottom of the page.

Click `Paradox Alarm Interface` and continue configuration there

- Info tab
  - Make sure `Start on boot`, `Watchdog` and `Auto update` options are active
- Configuration tab - add the following configuration. The configuration was made using the wiki from [here](https://github.com/ParadoxAlarmInterface/pai/wiki)

    ```yaml
    LOGGING_LEVEL_CONSOLE: 20
    LOGGING_LEVEL_FILE: 40
    CONNECTION_TYPE: IP
    SERIAL_PORT: /dev/ttyUSB0
    SERIAL_BAUD: 9600
    IP_CONNECTION_HOST: 192.168.0.3
    IP_CONNECTION_PORT: 10000
    IP_CONNECTION_PASSWORD: paradox
    KEEP_ALIVE_INTERVAL: 10
    LIMITS:
      zone: auto
      user: 1-10
      door: ''
      pgm: ''
      partition: '1'
      module: ''
      repeater: ''
      keypad: ''
      key-switch: ''
    SYNC_TIME: true
    SYNC_TIME_MIN_DRIFT: 120
    PASSWORD: 'xxx' -> replace with the panel PIN
    MQTT_ENABLE: true
    MQTT_HOST: 192.168.0.100
    MQTT_PORT: 1883
    MQTT_KEEPALIVE: 60
    MQTT_USERNAME: ha_mqtt
    MQTT_PASSWORD: HaMqttPass_123
    MQTT_HOMEASSISTANT_AUTODISCOVERY_ENABLE: true
    COMMAND_ALIAS:
      arm: partition all arm
      disarm: partition all disarm
    MQTT_COMMAND_ALIAS:
      armed_home: arm_stay
      armed_night: arm_sleep
      armed_away: arm
      disarmed: disarm
    HOMEASSISTANT_NOTIFICATIONS_EVENT_FILTERS:
      - live,alarm,-restore
      - live,trouble,-clock
      - live,tamper
    PUSHBULLET_CONTACTS: []
    PUSHBULLET_EVENT_FILTERS:
      - live,alarm,-restore
      - live,trouble,-clock
      - live,tamper
    PUSHOVER_EVENT_FILTERS:
      - live,alarm,-restore
      - live,trouble,-clock
      - live,tamper
    PUSHOVER_BROADCAST_KEYS: []
    SIGNAL_CONTACTS: []
    SIGNAL_EVENT_FILTERS:
      - live,alarm,-restore
      - live,trouble,-clock
      - live,tamper
    GSM_CONTACTS: []
    GSM_EVENT_FILTERS:
      - live,alarm,-restore
      - live,trouble,-clock
      - live,tamper
    IP_INTERFACE_ENABLE: false
    IP_INTERFACE_PASSWORD: paradox
    DUMMY_EVENT_FILTERS: []
    ```

- host TCP port - `10000`.

Press the `Start` button on the info page of the integration and check the `Log` section to make sure HomeAssistant connects succesfully to Paradox Alarm.

## HomeAssistant - UPS integration

In order to access different parameters of the UPS using the SNMP protocol, certain stepts need to be taken to identify the corresponding OID's.

Download the latest [MIB](https://www.cyberpowersystems.com/products/software/mib-files/) file from CyberPower.

Download and install a MIB browser to edit the file.

- Free MIB Browser
- [MIB Browser](https://www.ireasoning.com/mibbrowser.shtml)
- SNMP Browser.

Choose `File -> Open` and go to the folder where you stored the CyberPower MIB file and select it. Start by selecting your ip address or localhost as the address in the top right box.

Select from the tree explorer `private -> enterprises -> cps -> products -> ups` and double click a `leaf` on the tree to query the OID and return a value. The OID is listed at the bottom left. When double click on the OID, the values are shown on the right hand panel.

The OIDs from CyberPower need the `.0` at the end when used in another application. The values from viewer cannot be copied as they are.

In order to understand the units of an OID, look at the response data. It might be

- an integer
- ticks - e.g. time remaining in my example below
- a series of strings, e.g the 'Status', which  can then be used to develop the value_template in configuration.yaml.

Add the following code in `configurations.yaml` file to be able to monitor some usefull parameters.

```yaml
sensor:
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.4.2.1.0
    community: public
    port: 161
    name: UPS Output Voltage
    value_template: '{{ (value | int / 10 ) }}'
    unit_of_measurement: "V"
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.4.2.3.0
    community: public
    port: 161
    name: UPS Output Load
    value_template: '{{ (value | float) }}'
    unit_of_measurement: "%"
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.1.1.1.0
    community: public
    port: 161
    name: UPS Model
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.4.1.1.0
    community: public
    port: 161
    name: UPS Status
    value_template: >
      {% set vals = {'1': 'unknown', '2':'onLine', '3':'onBattery', '4':'onBoost', '5':'sleep', '6':'off', '7':'rebooting'} %}
      {{vals[value]}}
  - platform: snmp
    host: 192.168.0.2
    baseoid:  .1.3.6.1.4.1.3808.1.1.1.3.2.6.0
    community: public
    port: 161
    name: UPS Advanced Status
    value_template: >
      {% set vals = {'1': 'normal', '2':'Over Voltage', '3':'Under Voltage', '4':'Frequency failure', '5':'Blackout'} %}
      {{vals[value]}}
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.2.1.1.0
    community: public
    port: 161
    name: UPS Battery Status
    value_template: >
      {% set vals = {'1': 'unknown', '2':'Normal', '3':'Battery Low', '4':'Battery Not Present'} %}
      {{vals[value]}}
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.2.2.1.0
    community: public
    port: 161
    name: UPS Battery Capacity Raw
    value_template: '{{ (value | float) }}'
    unit_of_measurement: "%"
  - platform: snmp
    host: 192.168.0.2
    baseoid:  .1.3.6.1.4.1.3808.1.1.1.2.2.2.0
    community: public
    port: 161
    name: UPS Battery Voltage
    value_template: '{{ (value | int / 10 ) }}'
    unit_of_measurement: "V"
  - platform: snmp
    host: 192.168.0.2
    baseoid: .1.3.6.1.4.1.3808.1.1.1.2.2.4.0
    community: public
    port: 161
    name: UPS Run Time Remaining
    value_template: >-
      {% set time = (value | int) | int %}
      {% set minutes = ((time % 360000) / 6000) | int%}
      {% set hours = ((time % 8640000) / 360000) | int %}
      {% set days = (time / 8640000) | int %}
      {%- if time < 60 -%}
        Less then 1 min
        {%- else -%}
        {%- if days > 0 -%}
          {{ days }}d
        {%- endif -%}
        {%- if hours > 0 -%}
          {%- if days > 0 -%}
            {{ ' ' }}
          {%- endif -%}
          {{ hours }}hr
        {%- endif -%}
        {%- if minutes > 0 -%}
          {%- if days > 0 or hours > 0 -%}
            {{ ' ' }}
          {%- endif -%}
          {{ minutes }}min
        {%- endif -%}
      {%- endif -%}
  - platform: template
    sensors:
      ups_battery_capacity:
        unit_of_measurement: "%"
        value_template: "{{ states('sensor.ups_battery_capacity_raw') }}"
        friendly_name: "Battery Capacity"
        icon_template: >
          {% set level = states('sensor.ups_battery_capacity_raw') | float | multiply(0.1) | round(0,"floor") | multiply(10)| round(0) %}
          {% if is_state('sensor.ups_status', 'onLine') and is_state('sensor.ups_battery_capacity_raw' , '100.0' ) %}
            mdi:battery
          {% elif is_state('sensor.ups_status', 'onLine')  %}
            mdi:battery-charging-{{level}}
          {% else %}
            mdi:battery-{{level}}
          {% endif %}
```

Create a new tab in the `Overview` section called `UPS` and add a new `Entities Card` to it with the code below. Make sure an appropiate image with name `ups.png` is loaded in `/config/www/ups`

```yaml
type: entities
entities:
  - entity: sensor.ups_model
    name: Model
    icon: mdi:power-plug
  - entity: sensor.ups_status
    name: Status
    icon: mdi:power
  - entity: sensor.ups_battery_capacity
    name: Battery Capacity
  - entity: sensor.ups_run_time_remaining
    name: Run time remaining
    icon: mdi:av-timer
  - entity: sensor.ups_battery_status
    name: Battery Status
    icon: mdi:car-battery
  - entity: sensor.ups_battery_voltage
    name: Battery Voltage
    icon: mdi:car-battery
  - entity: sensor.ups_output_voltage
    name: Output Volts
    icon: mdi:power-socket-au
  - entity: sensor.ups_output_load
    name: Output Load
    icon: mdi:power-socket-au
  - entity: sensor.ups_advanced_status
    name: Advanced status
header:
  type: picture
  image: /local/ups/ups.png
  tap_action:
    action: none
  hold_action:
    action: none
```

## HomeAssistant - Integration of CCTV cameras

Add the following code in `configurations.yaml` file to be able to access the CCTV cameras connected to the Dahua DVR. Sensitive information is located in a separate file called `secrets.yaml`.

```yaml
# Configuration for CCTV camera with Dahua DVR
camera laterala:
  - platform: generic
    name: Camera laterala
    still_image_url: http://192.168.0.8:8000/cgi-bin/snapshot.cgi?channel=1
    stream_source: rtsp://admin:Darksourcer123@192.168.0.8:554/cam/realmonitor?channel=1&subtype=0
    username: !secret cctv_user
    password: !secret cctv_password
    authentication: digest
    verify_ssl: false
camera spate:
  - platform: generic
    name: Camera spate
    still_image_url: http://192.168.0.8:8000/cgi-bin/snapshot.cgi?channel=2
    stream_source: rtsp://admin:Darksourcer123@192.168.0.8:554/cam/realmonitor?channel=2&subtype=0
    username: !secret cctv_user
    password: !secret cctv_password
    authentication: digest
    verify_ssl: false
camera fata dreapta:
  - platform: generic
    name: Camera fata dreapta
    still_image_url: http://192.168.0.8:8000/cgi-bin/snapshot.cgi?channel=3
    stream_source: rtsp://admin:Darksourcer123@192.168.0.8:554/cam/realmonitor?channel=3&subtype=0
    username: !secret cctv_user
    password: !secret cctv_password
    authentication: digest
    verify_ssl: false
camera fata stanga:
  - platform: generic
    name: Camera fata stanga
    still_image_url: http://192.168.0.8:8000/cgi-bin/snapshot.cgi?channel=4
    stream_source: rtsp://admin:Darksourcer123@192.168.0.8:554/cam/realmonitor?channel=4&subtype=0
    username: !secret cctv_user
    password: !secret cctv_password
    authentication: digest
    verify_ssl: false
```

Open the `Overview` tab and add a new view with the followint configuration:

- Title: `Camere`
- Icon: `mdi:cctv`

 Add 4 `Picture Entity Card` with the following configuration:

- Entity: `camera.camera_fata_dreapta`
- Entity: `camera.camera_laterala`
- Entity: `camera.camera_fata_stanga`
- Entity: `camera.camera_spate`

## HomeAssistant - Google Assistant integration

To use Google Assistant, your Home Assistant configuration has to be externally accessible with a hostname and SSL certificate.

 1. Create a new project in the Actions on [Google console](https://console.actions.google.com/).
    - Click `New Project` and give your project a name.
    - Click on the `Smart Home card`, then click the `Start Building` button.
    - Click `Name your Smart Home` action under `Quick Setup` to give your Action a name - Home Assistant will appear in the Google Home app as `[test] <Action Name>`
    - Click on the Overview tab at the top of the page to go back.
    - Click `Build your Action`, then click `Add Action(s)`.
    - Add Home Assistant URL: `https://ha.sitram.eu/api/google_assistant` in the `Fulfillment URL` box.
    - Click `Save`.
    - Click the three little dots (more) icon in the upper right corner, select `Project settings`
    - Make note of the `Project ID` that are listed on the `GENERAL` tab of the `Settings` page.
 2. `Account linking` is required for your app to interact with Home Assistant.
    - Start by going back to the `Overview` tab.
    - Click on `Setup account linking` under the `Quick Setup` section of the `Overview` page.
    - If asked, leave options as they default `No, I only want to allow account creation on my website` and select `Next`.
    - Then if asked, for the `Linking type` select `OAuth` and `Authorization Code`. Click `Next`
    - Enter the following:
      - Client ID: `https://oauth-redirect.googleusercontent.com/r/[YOUR_PROJECT_ID]`. (Replace [`YOUR_PROJECT_ID]` with your project ID from above)
      - Client Secret: Anything you like, Home Assistant doesn’t need this field.
      - Authorization URL: `https://[YOUR HOME ASSISTANT URL:PORT]/auth/authorize.` (Replace [`YOUR HOME ASSISTANT URL:PORT]` with your values.)
      - Token URL (replace with your actual URL): `https://[YOUR HOME ASSISTANT URL:PORT]/auth/token`. (Replace `[YOUR HOME ASSISTANT URL:PORT]` with your values.) Click `Next`, then `Next` again.
    - In the `Configure` your client `Scopes` textbox, type email and click `Add scope`, then type name and click `Add scope` again.
    - Do `NOT` check `Google to transmit clientID and secret via HTTP basic auth header`.
    - Click `Next`, then click `Save`
 3. Select the `Develop` tab at the top of the page, then in the upper right hand corner select the `Test` button to generate the draft version Test App. If you don’t see this option, go to the `Test` tab instead, click on the `Settings` button in the top right below the header, and ensure `On device testing` is enabled (if it isn’t, enable it).
 4. Add the `google_assistant` integration configuration to your `configuration.yaml` file and restart Home Assistant .
 5. Add services in the Google Home App (Note that app versions may be slightly different.)
    - Open the Google Home app.
    - Click the `+` button on the top left corner, click `Set up device`, in the “Set up a device” screen click “Works with Google”. You should have `[test] <Action Name>` listed under ‘Add new’. Selecting that should lead you to a browser to login your Home Assistant instance, then redirect back to a screen where you can set rooms and nicknames for your devices if you wish.
 6. If you want to allow other household users to control the devices:
    - Open the project you created in the [Actions on Google console](https://console.actions.google.com/).
    - Click `Test` on the top of the page, then click Simulator located to the page left, then click the three little dots (more) icon in the upper right corner of the console.
    - Click `Manage user access`. This redirects you to the Google Cloud Platform IAM permissions page.
    - Click `ADD` at the top of the page.
    - Enter the email address of the user you want to add.
    - Click `Select a role` and choose `Project < Viewer`.
    - Click `SAVE`
    - Copy and share the Actions project link `(https://console.actions.google.com/project/YOUR_PROJECT_ID/simulator)` with the new user.
    - Have the new user open the link with their own Google account, agree to the Terms of Service popup, then select `Start Testing`, select `VERSION - Draft` in the dropdown, and click `Done`.
    - Have the new user go to their `Google Assistant` app to add `[test] your app name` to their account.
 7. Enable Device sync
    - If you want to support active reporting of state to Google’s server (configuration option `report_state`) and synchronize Home Assistant devices with the Google Home app (`google_assistant.request_sync service`), you will need to create a service account. It is recommended to set up this configuration key as it also allows the usage of the following command, “Ok Google, sync my devices”. Once you have set up this component, you will need to call this service (or command) each time you add a new device in Home Assistant that you wish to control via the Google Assistant integration. This allows you to update devices without unlinking and relinking an account.
    - Service Account
        - In the Google Cloud Platform Console, go to the [Create Service account key](https://console.cloud.google.com/apis/credentials/serviceaccountkey) page.
        - At the top left of the page next to `Google Cloud Platform logo`, select your project created in the Actions on Google console. Confirm this by reviewing the project ID and it ensure it matches.
        - From the Service account list, select `CREATE SERVICE ACCOUNT`.
        - In the Service account name field, enter a name.
        - In the Service account ID field, enter an ID.
        - From the Role list, select `Service Accounts` > `Service Account Token Creator`.
        - Click `CONTINUE` and then `DONE`. You are returned to the service account list, and your new account is shown.
        - Click the three dots menu under `Actions` next to your new account, and click `Manage keys`. You are taken to a `Keys` page.
        - Click `ADD KEY` then `Create new key`. Leave the `key type` as `JSON` and click `CREATE`. A JSON file that contains your key downloads to your computer.
        - Use the information in this file or the file directly to add to the service_account key in the configuration.
        - Click   .
    - HomeGraph API
        - Go to the [Google API Console](https://console.cloud.google.com/apis/api/homegraph.googleapis.com/overview).
        - At the top left of the page next to `Google Cloud Platform` logo, select your project created in the `Actions` on Google console. Confirm this by reviewing the project ID and it ensure it matches.
        - Click `Enable HomeGraph API`.
        - Try `OK Google, sync my devices` - the Google Home app should import your exposed Home Assistant devices and prompt you to assign them to rooms.

Add the following code in `configurations.yaml` file with the devices in Home Assistant that you wish to control via the Google Assistant integration.

```yaml
# Google assistant integration
google_assistant:
  project_id: smart-home-e8da1
  service_account: !include service_account_google_assistant.json
  report_state: true
  secure_devices_pin: "xxxx" -> replace with alarm panel PIN
  exposed_domains:
    - alarm_control_panel
    - camera
    - climate
  entity_config:
    # Entities exposed to Google Assistant from the alarm_control_panel domain
    alarm_control_panel.toata_casa:
      name: House alarm
      room: Entryway
    # Entities exposed to Google Assistant from camera domain
    camera.camera_fata_dreapta:
      name: Security camera front right
      room: Frontyard
    camera.camera_fata_stanga:
      name: Security camera front left
      room: Frontyard
    camera.camera_laterala:
      name: Security camera lateral
      room: Frontyard
    camera.camera_spate:
      name: Security camera backyard
      room: Back yard
    # Entities exposed to Google Assistant from climate domain
    climate.ac_dormitor_alb:
      name: Guest bedroom AC
      room: Bedroom
    climate.ac_dormitor:
      name: Master Bedroom AC
      room: Master Bedroom
    climate.ac_living:
      name: Living Room AC
      room: Living Room
    climate.netatmo_smart_thermostat:
      name: Thermostat
      room: Living Room
```

Reload HomeAssistant configuration and test that the devices are visible in Home App on your mobile phone.

## HomeAssistant - Recorder integration

In order to reduce the size of the database the make the following changes to the Recorder configuration in `configuration.yaml`. Additional information can be found [here](https://community.home-assistant.io/t/how-to-reduce-your-database-size-and-extend-the-life-of-your-sd-card/205299).

Make sure that all the integration are configured before this step is done.

Only use includes or excludes for history or logbook. Do not use a mix of both in the one integration. The logic is completely busted. The recorder seems ok to mix includes and excludes.

Every time a new integration is added, review the recorder integration and decide if it's worth beeing added to the exclude or include list.

```yaml
# Settings for recorder integration in order to reduce the size of the database
# configuration was done based in information fron https://community.home-assistant.io/t/how-to-reduce-your-database-size-and-extend-the-life-of-your-sd-card/205299
recorder:
  purge_keep_days: 30
  exclude:
    domains:
      - automation
      - binary_sensor
      - camera
      - group
      - sensor
      - sun
      - switch
      - weather
      - zone
  include:
    domains:
      - climate
      - device_tracker
      - light
      - media_player
      - person
      - vacuum
    entities:
      - alarm_control_panel.toata_casa
      - binary_sensor.oneplus_a6013_is_charging
      - binary_sensor.samsung_s10_is_charging
      - sensor.oneplus_a6013_geocoded_location
      - sensor.samsung_s10_geocoded_location
      - sensor.ac_dormitor_alb_inside_temperature
      - sensor.ac_dormitor_inside_temperature
      - sensor.ac_living_inside_temperature
      - sensor.run_status
      - sensor.speedtest_download
      - sensor.speedtest_ping
      - sensor.speedtest_upload
      - sensor.ups_status
      - switch.sonoff_100111e4eb

history:
  include:
    domains:
      - climate
      - device_tracker
      - light
      - media_player
      - person
      - vacuum
    entities:
      - alarm_control_panel.toata_casa
      - binary_sensor.oneplus_a6013_is_charging
      - binary_sensor.samsung_s10_is_charging
      - sensor.oneplus_a6013_geocoded_location
      - sensor.samsung_s10_geocoded_location
      - sensor.ac_dormitor_alb_inside_temperature
      - sensor.ac_dormitor_inside_temperature
      - sensor.ac_living_inside_temperature
      - sensor.run_status
      - sensor.speedtest_download
      - sensor.speedtest_ping
      - sensor.speedtest_upload
      - sensor.ups_status
      - switch.sonoff_100111e4eb

logbook:
  include:
    domains:
      - climate
      - device_tracker
      - light
      - media_player
      - person
      - vacuum
    entities:
      - alarm_control_panel.toata_casa
      - binary_sensor.oneplus_a6013_is_charging
      - binary_sensor.samsung_s10_is_charging
      - sensor.oneplus_a6013_geocoded_location
      - sensor.samsung_s10_geocoded_location
      - sensor.ac_dormitor_alb_inside_temperature
      - sensor.ac_dormitor_inside_temperature
      - sensor.ac_living_inside_temperature
      - sensor.run_status
      - sensor.speedtest_download
      - sensor.speedtest_ping
      - sensor.speedtest_upload
      - sensor.ups_status
      - switch.sonoff_100111e4eb
```
