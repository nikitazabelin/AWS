import boto3
import cfnresponse
import random
import string

def create_temporary_password():
    """Generate a random temporary password."""
    length = 12
    characters = string.ascii_letters + string.digits + string.punctuation
    return ''.join(random.choice(characters) for i in range(length))

def handler(event, context):
    try:
        iam = boto3.client('iam')
        user_name = event['ResourceProperties']['UserName']
        temporary_password = create_temporary_password()
        iam.create_login_profile(
            UserName=user_name,
            Password=temporary_password,
            PasswordResetRequired=True
        )
        cfnresponse.send(event, context, cfnresponse.SUCCESS)
    except Exception as e:
        print(e)
        cfnresponse.send(event, context, cfnresponse.FAILED)
