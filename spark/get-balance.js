//GET bonfire mainnet multisig balance
let bfAddress = "0x67ED0100E6Bf5E8E63Cc1F917a339563dEd204f4";

const rpcURL = 'https://rinkeby.infura.io/v3/a95f31b64bf04504ac6279d19651c2be\n';// Your RPC URL goes here
const web3 = new Web3(rpcURL)

//const address = '0x1f7DAF77668306702128c95D0F0F6aeD8161564E';// Your account address goes here

web3.eth.getBalance(bfAddress, (err, wei) => {
    let balance = web3.utils.fromWei(wei, 'ether');
    console.log('balance', balance);

    window.updateBalance(balance);
});
