from os import environ

import boto3


def lambda_handler(event, context):
    distribution_id = environ["DISTRIBUTION_ID"]
    cloudfront_client = boto3.client('cloudfront')

    response = cloudfront_client.get_distribution_config(Id=distribution_id)
    etag = response['ETag']
    distribution_config = response['DistributionConfig']
    distribution_config['Enabled'] = False

    print(f"Disabling distribution '{distribution_id}'...")

    cloudfront_client.update_distribution(
            DistributionConfig=distribution_config,
            Id=distribution_id,
            IfMatch=etag
    )
    print("Success. The distribution will be disabled shortly.")