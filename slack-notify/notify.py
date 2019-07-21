import argparse
import json
import os
import slack

argument_parser = argparse.ArgumentParser(description="Sends build notification to Slack")
argument_parser.add_argument('--channel', help='Channel ID or name that notification should be sent to')
argument_parser.add_argument('--icon-emoji', default=":warning:", help='Icon emoji for the message, eg. :joy:')
argument_parser.add_argument('--username', default='Bot', help='Username to author the message with')
argument_parser.add_argument('attachment', help='Path to attachment for message')

args = argument_parser.parse_args()
with open(args.attachment, 'r') as f:
    attachments = json.load(f)

client = slack.WebClient(token=os.environ['SLACK_TOKEN'])
client.chat_postMessage(
    channel=args.channel,
    icon_emoji=args.icon_emoji,
    username=args.username,
    attachments=attachments
)
