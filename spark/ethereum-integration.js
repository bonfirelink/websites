let bfAddress = "0x67ED0100E6Bf5E8E63Cc1F917a339563dEd204f4";


commitForm = document.getElementById('commit-form');
if (commitForm !== null) {
    commitForm.addEventListener('submit', function (event) {

        // Grab the selected amount out of the DOM upon form submission.
        const checkedDonationElement = document.querySelector('input[name="donation"]:checked');

        const amountInCHF = checkedDonationElement !== null ? parseInt(checkedDonationElement.value) : 0;
        console.log("amount in CHF", amountInCHF);

        // Attention: hard-coded conversion rate!
        const amountInEther = amountInCHF / 180;
        console.log('amount in Ether', amountInEther);

        const amountInWei = parseInt(web3.toWei(amountInEther, 'ether'));
        console.log("amount in Wei", amountInWei);

        // Push transaction to rinkeby testnet
        const transactionParameters = {
            nonce: '0x00', // ignored by MetaMask
            gasPrice: '0x09184e72a000', // customizable by user during MetaMask confirmation.
            gasLimit: '0x0710',  // customizable by user during MetaMask confirmation.
            to: bfAddress, // Required except during contract publications.
            from: web3.currentProvider.publicConfigStore.getState().selectedAddress, // must match user's active address.
            value: "0x" + amountInWei.toString(16), // Only required to send ether to the recipient from the initiating external account.
            data: '', // Optional, but used for defining smart contract creation and interaction.
            chainId: 3 // Used to prevent transaction reuse across blockchains. Auto-filled by MetaMask.
        };
        console.log('transaction value', transactionParameters.value);

        try {
            ethereum.enable();
            ethereum.sendAsync({
                method: 'eth_sendTransaction',
                params: [transactionParameters],
                from: ethereum.selectedAddress,
            }, function () {
                window.location.href = "state";
            });
            event.preventDefault();

        } catch (error) {
            console.error(error);
        }

    });
}