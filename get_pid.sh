ps -AF|grep  '[ ]editorbank_http2s3[ ]' | sed -r 's/\s+/\t/g' | cut -f2