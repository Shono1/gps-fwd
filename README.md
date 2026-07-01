# gps-fwd
A BlueOS extension for routing a limited selection of MAVLink messages between vehicles

# Usage
Run this extension on the vehicle that you want to forward messages from. Ensure there is a UDP client endpoint on this vehicle pointing to the "main" UDP server endpoint described in **main.conf**.

To modify which messages get sent or received, append to / remove from the **AllowMsgId** in/out fields in **main.conf**. I recommend not allowing "HEARTBEAT" messages (ID 0) to be forwarded or accepted, as these will convince the vehicle they are forwared to that they have magically become the vehicle the message was sent from. This can be sad.

You can also add endpoints and stuff and play around with other options. Running *mavlink-routerd* is literally the only thing this extension does. See the MAVLink router documentation for more details.

# Building
1. Clone / fork this repository
2. Navigate into the folder you cloned it to
3. Run ```docker buildx build --platform arm64 -t gps-fwd:your-tag --load .```

# Loading as an extension
To load the extension manually, you can go to the install tab on the extension page, hit the "+", then click "Load from file" and follow the prompts. 

If you want to be fancy, you can also upload the image to a local Docker repository and tell Kraken (the exentsion service) to pull your image and make it an extension. A sample POST request payload is included below:

```
POST http://192.168.1.111:9134/v2.0/extension/
{
  "identifier": "automata1.lan:5000/gps-fwd",
  "tag": "router",
  "name": "gps",
  "docker": "automata1.lan:5000/gps-fwd",
  "enabled": true,
  "permissions": "{\"HostConfig\":{\"NetworkMode\": \"host\", \"Privileged\": true}}"
}
```

You can use curl or just use the Kraken v2 API documentation page. 