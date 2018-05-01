# docker-node-raumserver [![Docker Pulls](https://img.shields.io/docker/pulls/gutmensch/node-raumserver.svg)](https://registry.hub.docker.com/u/gutmensch/node-raumserver/)

Raumserver is a HTTP REST API daemon for RF devices created by ChriD (see https://github.com/ChriD/node-raumserver). It can be installed on RF devices itself or in the same network with communication via UPnP. This image uses s6-overlay to create the nodejs process and a nginx process, which proxy passes /raumserver to the app and serves /var/www/html under / by default. The node app needs to bind to the host network due to UPnP communication, therefor the default nginx listens on the unusual port 3535.

Current version: 0.1.4 (30.04.2018)

## Usage
```
docker run --net=host -ti gutmensch/node-raumserver
```

## WebClient
This image now features a simple AJAX webclient. By default it should be available after running the image at http://docker:3535/. The Quick Source menu is not yet dynamic. Take a look at the top of main.js, if you want to rebuild - Playlists and HTTP Streams are supported, I didn't get containers to work (see loadContainer in the raumserver documentation). The client's interface was designed to be as suitable for smartphones/tablets as possible, therefor some constraints with regards to line length etc. pp.<br />
<img src="https://github.com/gutmensch/docker-node-raumserver/raw/master/images/screenshot.png" width="500" />

## Raumserver version and zone config
```
$ curl docker:3535/raumserver/data/getVersion -s | python -mjson.tool
{
    "action": "getVersion",
    "data": {
        "raumkernelLib": "1.2.21",
        "raumserverLib": "0.1.4"
    },
    "error": false,
    "msg": "",
    "requestUrl": "/raumserver/data/getVersion"
}
$ curl docker:3535/raumserver/data/getZoneConfig -s | python -mjson.tool
{
    "action": "getZoneConfig",
    "data": {
        "zoneConfig": {
            "$": {
                "numRooms": "4",
                "spotifyMode": "singleRoom"
            },
            "zones": [
                {
                    "zone": [
                        {
                            "$": {
                                "udn": "uuid:7310357F-C81B-44D2-AF2B-B1BACC9803B9"
                            },
                            "room": [
                                {
                                    "$": {
                                        "name": "Wohnzimmer",
                                        "powerState": "AUTOMATIC_STANDBY",
                                        "udn": "uuid:b1e1694c-cda7-403d-a671-8d7266ec0f30"
                                    },
                                    "renderer": [
                                        {
                                            "$": {
                                                "name": "Connector Wohnzimmer",
                                                "udn": "uuid:f6030ad8-b400-4e2e-a260-f79580ff68f7"
                                            }
                                        }
                                    ]
                                }
                            ]
                        },
                        {
                            "$": {
                                "udn": "uuid:C43C1A1D-AED1-472B-B0D0-210B7925000E"
                            },
                            "room": [
                                {
                                    "$": {
                                        "name": "Bad",
                                        "powerState": "AUTOMATIC_STANDBY",
                                        "udn": "uuid:48459864-dce8-42cf-a483-d64734881798"
                                    },
                                    "renderer": [
                                        {
                                            "$": {
                                                "name": "Speaker Bad",
                                                "udn": "uuid:635fafa2-1d5b-4f2e-9fc2-671a866520dd"
                                            }
                                        }
                                    ]
                                },
                                {
                                    "$": {
                                        "name": "Schlafzimmer",
                                        "powerState": "AUTOMATIC_STANDBY",
                                        "udn": "uuid:5d366950-69f4-4534-8ca4-1b18b7dd00db"
                                    },
                                    "renderer": [
                                        {
                                            "$": {
                                                "name": "Speaker Schlafzimmer",
                                                "udn": "uuid:183bd2ad-e56a-4843-b0f9-dd19db6fd066"
                                            }
                                        }
                                    ]
                                },
                                {
                                    "$": {
                                        "name": "Kueche",
                                        "powerState": "AUTOMATIC_STANDBY",
                                        "udn": "uuid:8dd0aac7-ecb0-44cb-a3b9-91548c1e88f9"
                                    },
                                    "renderer": [
                                        {
                                            "$": {
                                                "name": "Speaker Kueche",
                                                "udn": "uuid:2c09e94e-34b8-45e0-8dca-2a5b162a6984"
                                            }
                                        }
                                    ]
                                }
                            ]
                        }
                    ]
                }
            ]
        }
    },
    "error": false,
    "msg": "",
    "requestUrl": "/raumserver/data/getZoneConfig"
}
```

## Command reference
https://github.com/ChriD/Raumserver/wiki/Available-control-and-data-requests
