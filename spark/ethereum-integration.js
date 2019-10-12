document.getElementById('commit-form').addEventListener('submit', function(e){ //say this is an anchor
    console.log("form submit");
    e.preventDefault();

    //Push transaction to rinkeby testnet
    const transactionParameters = {
        nonce: '0x00', // ignored by MetaMask
        gasPrice: '0x09184e72a000', // customizable by user during MetaMask confirmation.
        gasLimit: '0x2710',  // customizable by user during MetaMask confirmation.
        to: '0x67ED0100E6Bf5E8E63Cc1F917a339563dEd204f4', // Required except during contract publications.
        from: "0x2c2aa7c47AB3f0Cb74DcFa1cFDDa673c0653b447", // must match user's active address.
        value: '0x10000000000000', // Only required to send ether to the recipient from the initiating external account.
        data: '', // Optional, but used for defining smart contract creation and interaction.
        chainId: 3 // Used to prevent transaction reuse across blockchains. Auto-filled by MetaMask.
    };
    ethereum.enable();
    ethereum.sendAsync({
        method: 'eth_sendTransaction',
        params: [transactionParameters],
        from: ethereum.selectedAddress,
    }, function () {
        console.log("sent?");
    });
});

//GET bonfire mainnet multisig balance
const rpcURL = 'https://mainnet.infura.io/v3/a95f31b64bf04504ac6279d19651c2be';// Your RPC URL goes here
const web3 = new Web3(rpcURL)
const address = '0x1f7DAF77668306702128c95D0F0F6aeD8161564E';// Your account address goes here
web3.eth.getBalance(address, (err, wei) => {
    balance = web3.utils.fromWei(wei, 'ether')
    console.log(balance);
});
