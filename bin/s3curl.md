# s3curl.sh

The simple CLI for S3 compatible storage

## List of buckets

```bash
s3curl.sh
s3curl.sh GET /
```

Use alternative S3 server settings

```bash
S3_PROTOCOL=http S3_HOST=localhost S3_PORT=8001 S3_ACCESS_KEY=YOUR-ACCESS-KEY-HERE S3_SECRET_KEY=YOUR-SECRET-KEY-HERE s3curl.sh GET /
```

or

```bash
export S3_PROTOCOL=http
export S3_HOST=localhost
export S3_PORT=8001
export S3_ACCESS_KEY=YOUR-ACCESS-KEY-HERE
export S3_SECRET_KEY=YOUR-SECRET-KEY-HERE
s3curl.sh GET /
```

## Create bucket

```bash
s3curl.sh PUT /mybucket
```

## Create key in bucket

```bash
s3curl.sh PUT /mybucket/key value
```

## List of keys in bucket

```bash
s3curl.sh GET /mybucket
```

## Get value

```bash
s3curl.sh GET /mybucket/key
```

## Delete key

```bash
s3curl.sh DELETE /mybucket/key
```

## Delete the bucket if it is empty

```bash
s3curl.sh DELETE /mybucket
```
