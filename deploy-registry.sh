docker run \
    --name registry \
    -e SETTINGS_FLAVOR=s3 \
    -e AWS_BUCKET=bucket-name \
    -e STORAGE_PATH=/docker-registry \
    -e AWS_KEY=<your-docker-registry-iam-user-key> \
    -e AWS_SECRET=<your-docker-registry-iam-user-secret-key> \
    -e SEARCH_BACKEND=sqlalchemy \
    -e AWS_REGION="us-west-2" \
    --restart=always \
    -p 5000:5000 \
    -d \
    registry
