# Assignment 4 - IPFS Integration

## Objective
Upload data to IPFS and retrieve it back using the returned CID.

## Library Used
- **Library:** `web3.storage`
- **Why this library:**
  - Simple JavaScript API for uploading files to IPFS.
  - Automatically handles storage and returns content-addressed CID.
  - Good fit for quick lab workflows.

## How Storage and Retrieval Works
1. Script creates a sample JSON object.
2. JSON object is converted into a `File` instance.
3. File is uploaded through `Web3Storage.put()`.
4. IPFS returns a CID representing immutable content.
5. Script builds a gateway URL using that CID.
6. Script fetches content back from gateway and logs it.

## Environment Variable Requirement
Do not hardcode API tokens.

Set token as environment variable:

```env
WEB3_STORAGE_TOKEN=<your_web3_storage_token>
```

## Run Steps
1. Install package:
   ```bash
   npm install web3.storage
   ```
2. Export token in environment (or set in `.env` and load it in your runner).
3. Run:
   ```bash
   node ipfs.js
   ```

## Output Placeholders
- CID: `<example>`
- Gateway Link: `https://<cid>.ipfs.w3s.link`

## Screenshot Placeholders
- [Screenshot: script execution]
- [Screenshot: printed CID]
- [Screenshot: gateway output]
