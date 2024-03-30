var crypt = require('crypto');

var S3_ACCESS_KEY = process.env.S3_ACCESS_KEY;
var S3_SECRET_KEY = process.env.S3_SECRET_KEY;

function s3_content_type(r) {
    var ret = r.headersIn["Content-Type"] || "application/xml";
    r.log('content_type: ' + ret);
    return ret;
}

function s3_date(r) {
    var ret = new Date().toString();
    r.log('date: ' + ret);
    return ret;
}

function s3_authorization(r) {
    var signed_text=`${r.method}\n\n${s3_content_type(r)}\n${s3_date(r)}\n${r.uri}`;
    r.log('signed_text: ' + (signed_text.replace(/[\n]/g,"\\n")));
    var signature = crypt.createHmac("sha1", S3_SECRET_KEY).update(signed_text).digest("base64");
    var ret = `AWS ${S3_ACCESS_KEY}:${signature}`;
    r.log('authorization: ' + ret);
    return ret;
}

export default {
    s3_content_type
    ,s3_date
    ,s3_authorization
};
