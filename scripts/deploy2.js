const { ethers, network } = require("hardhat")

async function main() {
  const addresses = [
    "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266",
    "0x70997970c51812dc3a010c7d01b50e0d17dc79c8",
    "0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc",
    "0x90f79bf6eb2c4f870365e785982e1f101e93b906",
    "0x15d34aaf54267db7d7c367839aaf71a00a2c6a65",
    "0x9965507d1a55bcc2695c58ba16fb37d819b0a4dc",
  ]
  const SimpleStorageFactory = await ethers.getContractFactory("Election")

  console.log("<<<<<<<<<<Deploying contract>>>>>>>>>>")

  const simpleStorage = await SimpleStorageFactory.deploy(addresses[0])
  await simpleStorage.deployed()

  console.log(`Address: ${simpleStorage.address}`)
  console.log(network.config)
  console.log(await ethers.provider.getBlockNumber())
  await simpleStorage.addAddress(addresses[1])
  console.log(
    await simpleStorage.purpose("To run an election for football players")
  )

  await simpleStorage.authorise(addresses[0])
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error)
    process.exit(1)
  })
