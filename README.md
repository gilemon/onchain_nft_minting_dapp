# OnChain Enigma Picture minting dapp 🥨

This repo provides a nice and easy way for linking an existing NFT smart contract to this minting dapp. There are two ways of using this repo, you can go the simple route or the more complex one.

The simple route is so simple, all you need to do is download the build folder on the release page and change the configuration to fit your needs. (Follow the video for a walk through).

The more complex route allows you to add additional functionality if you are comfortable with coding in react.js. (Follow the below instructions for a walk through).

## Installation 🛠️

If you are cloning the project then run this first, otherwise you can download the source code on the release page and skip this step.

```sh
git clone hhttps://github.com/gilemon/onchain_nft_minting_dapp.git
```

Make sure you have node.js installed so you can use npm, then run:

```sh
npm install
```

## Usage ℹ️

In order to make use of this dapp, all you need to do is change the configurations to point to your smart contract as well as update the images and theme file.

For the most part all the changes will be in the `public` folder.

To link up your existing smart contract, go to the `public/config/config.json` file and update the following fields to fit your smart contract, network and marketplace details. The cost field should be in wei.

Note: this dapp is designed to work with the intended NFT smart contract, that only takes one parameter in the mint function "mintAmount". But you can change that in the App.js file if you need to use a smart contract that takes 2 params.

```json

{
  "CONTRACT_ADDRESS": "0x15AcfD69842B52B5ef4c7c57a6468FFf96bB146C",
  "SCAN_LINK": "https://rinkeby.etherscan.io/token/0x15AcfD69842B52B5ef4c7c57a6468FFf96bB146C",
  "NETWORK": {
    "NAME": "Rinkeby",
    "SYMBOL": "ETH",
    "ID": 4
  },
  "NFT_NAME": "OnChain Picture",
  "SYMBOL": "OCP",
  "MAX_SUPPLY": 100,
  "WEI_COST": 75000000000000000,
  "DISPLAY_COST": 0.075,
  "GAS_LIMIT": 469785,
  "MARKETPLACE": "Opeansea",
  "MARKETPLACE_LINK": "https://opensea.io/collection/nerdy-coder-clones",
  "SHOW_BACKGROUND": true,
  "NFT_PICTURE_WIDTH": 50,
  "NFT_PICTURE_HEIGHT": 50
}

```

Make sure you copy the contract ABI from remix and paste it in the `public/config/abi.json` file.
(follow the youtube video if you struggle with this part).

Now you will need to create and change 2 images and a gif in the `public/config/images` folder, `bg.png`, `example.gif` and `logo.png`.

Next change the theme colors to your liking in the `public/config/theme.css` file.

```css
:root {
  --primary: #aaa;
  --primary-text: #fff;
  --secondary: #FEFEFF;
  --secondary-text: #020D2C;
  --accent: #A0C4F7;
  --accent-text: #ffffff;
}
```

Now you will need to create and change the `public/favicon.ico`, `public/logo192.png`, and
`public/logo512.png` to your brand images.

Remember to update the title and description the `public/index.html` file

```html
<title>Nerdy Coder Clones</title>
<meta name="description" content="Mint your Nerdy Coder Clone NFT" />
```

Also remember to update the short_name and name fields in the `public/manifest.json` file

```json
{
  "short_name": "OCP",
  "name": "OnChain Enigma Picture"
}
```

After all the changes you can run.

```sh
npm run start
```

Or create the build if you are ready to deploy.

```sh
npm run build
```

Now you can host the contents of the build folder on a server.

That's it! you're done.
