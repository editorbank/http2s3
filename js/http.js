function njs_version(r) {
    r.return(200, njs.version);
}

function hello_name_function(r) {
    return(process.env["HELLO_NAME"]||"world");
}

function authorization(r) {
    r.log();('XXXXXX');
    return "XXXXXX"
}

export default {
    njs_version
    ,hello_name_function
    ,authorization
};
