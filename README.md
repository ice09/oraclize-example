# Create you own Oracle

This sample application is based on the https://github.com/ether-camp/oraclize-example of the Ethereum Studio

* Clone the project to your workspace.
* Select the project and start a sandbox. It will use Oraclize sandbox plugin with the following params (see ethereum.json):
```
"plugins": {
  "oraclize": {
    "networkID": 161,
    "loadRealData": true
  }
},
```
* Open a dialog of contract `Contract` and call `update()` with value 100000000000000000 in advanced parameters.

You will see requests and response in Oraclize Panel and contract logs in Ethereum Console.
