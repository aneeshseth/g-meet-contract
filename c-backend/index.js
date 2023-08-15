const Web3 = require("web3");
const calendarABI = require("./ABI");

const url =
  "https://eth-mainnet.g.alchemy.com/v2/QhqLIQLJWWbh7kRvCcx-1PWC2mIhORb5";
const contractAddress = "0xd9145CCE52D386f254917e481eB44e9943F39138";

const web3 = new Web3(new Web3.providers.HttpProvider(url));
const contract = new web3.eth.Contract(calendarABI, contractAddress);
contract.events
  .SessionScheduled({
    fromBlock: 0,
  })
  .on("data", async function (e) {
    //possibly a webhook
  });
