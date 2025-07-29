const speakeasy = require("speakeasy");
const QRCode = require("qrcode");

// Generate 2FA secret
const secret = speakeasy.generateSecret({ name: "SmartWallet 2FA" });

// Display QR code
QRCode.toDataURL(secret.otpauth_url, function (err, data_url) {
    console.log("Scan this QR with Google Authenticator:");
    console.log(data_url);
});

// Verify token example
const token = '123456'; // Replace with token from app
const verified = speakeasy.totp.verify({
    secret: secret.base32,
    encoding: 'base32',
    token: token
});
console.log("2FA Verified:", verified);
