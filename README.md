# Build you own Oracle

This sample application is based on the <a href='https://github.com/ether-camp/oraclize-example'>oraclize-example</a> of the <a href='http://live.ether.camp'>Ethereum Studio</a> and is the implementation part to the blog posts <a href='http://blockchainers.org/index.php/2016/06/12/gambling-with-oracles/'>Gambling with Oracles</a> and <a href='http://blockchainers.org/index.php/2016/07/26/create-your-own-…-and-oraclize-it/'>Build your own Oracle with Ethereum Studio</a>.

* Clone the project to your workspace.
```
git clone https://github.com/ice09/oraclize-example.git
cd oraclize-example
```
* Start the web server for your own Oracle
```
npm install http-server -g
http-server
```
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
