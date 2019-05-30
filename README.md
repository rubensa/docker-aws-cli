# AWS CLI Docker Image

This image provides the AWS CLI.

## Providing Credentials

Credentials can be provided in any of the aws-cli supported formats.

### Using credentials file

If you need to create the credentials file, you can use the aws-cli configure command by using the following command:

```
docker run --rm --name "aws-cli" -it \
	-v $HOME/.aws:/home/awscli/.aws \
	-u `stat -c "%u:%g" "$HOME"/.aws` \
	rubensa/aws-cli aws configure
```

From that point on, simply mount the directory containing your config.

```
docker run --rm --name "aws-cli" \
	-v $HOME/.aws:/home/awscli/.aws \
	-u `stat -c "%u:%g" "$HOME"/.aws` \
	rubensa/aws-cli aws s3 ls
```

### Using environment variables

This is supported, although NOT encouraged, as the environment variables can end up in command-line history, available for container inspection, etc.

- AWS_ACCESS_KEY_ID` - specify the access key ID
- AWS_SECRET_ACCESS_KEY` - the secret access key

```
docker run --rm -e AWS_ACCESS_KEY_ID=my-key-id -e AWS_SECRET_ACCESS_KEY=my-secret-access-key -v $(pwd):/home/awscli/aws-cli rubensa/aws-cli aws s3 ls 
```

## Running

You can interactively run the container by mapping current user UID:GUID, AWS credentials and working directory.

```
docker run --rm --name "aws-cli" -it \
	-v $HOME/.aws:/home/awscli/.aws \
	-v $(pwd):/home/awscli/aws-cli \
	-u `stat -c "%u:%g" "$HOME"/.aws` \
	rubensa/aws-cli
```

This way, any file created in the container initial working directory is writen and owned by current host user in the lauch directory.

