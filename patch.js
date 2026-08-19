const fs = require('fs');
const origChmodSync = fs.chmodSync;
fs.chmodSync = function(path, mode) {
    try {
        origChmodSync(path, mode);
    } catch (e) {
        if (e.code === 'ENOENT') {

        } else {
            throw e;
        }
    }
};
console.log("🛠️ Alpine OS Patch Applied Successfully!");
