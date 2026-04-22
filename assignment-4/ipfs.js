// Import Web3Storage client for IPFS storage and retrieval.
const { Web3Storage, File } = require("web3.storage");

// Reads API token from environment variable.
// NOTE: Set WEB3_STORAGE_TOKEN in your .env or environment before running.
const token = process.env.WEB3_STORAGE_TOKEN;

// Creates a Web3Storage client using the provided token.
function createStorageClient() {
    if (!token) {
        throw new Error("WEB3_STORAGE_TOKEN is not set. Please configure it in your environment.");
    }

    return new Web3Storage({ token });
}

// Uploads a JSON object as a file to IPFS and returns the resulting CID.
async function uploadJsonToIpfs(client, dataObject) {
    const jsonString = JSON.stringify(dataObject, null, 2);
    const file = new File([jsonString], "sample-data.json", { type: "application/json" });

    const cid = await client.put([file], {
        wrapWithDirectory: false,
        name: "blockchain-lab-assignment-4"
    });

    return cid;
}

// Retrieves uploaded JSON content back from IPFS using an HTTP gateway.
async function retrieveFromGateway(cid) {
    const gatewayUrl = `https://${cid}.ipfs.w3s.link`;
    const response = await fetch(gatewayUrl);

    if (!response.ok) {
        throw new Error(`Failed to fetch from gateway: ${response.status} ${response.statusText}`);
    }

    const text = await response.text();
    return { gatewayUrl, text };
}

// Main workflow: create sample object, upload to IPFS, retrieve by CID, and log results.
async function main() {
    const client = createStorageClient();

    const sampleData = {
        title: "Blockchain Lab Assignment 4",
        description: "This sample JSON object is uploaded to IPFS.",
        timestamp: new Date().toISOString()
    };

    const cid = await uploadJsonToIpfs(client, sampleData);
    const { gatewayUrl, text } = await retrieveFromGateway(cid);

    console.log("CID:", cid);
    console.log("Gateway Link:", gatewayUrl);
    console.log("Retrieved Content:", text);
}

// Execute script and print readable errors.
main().catch((error) => {
    console.error("IPFS script failed:", error.message);
});
