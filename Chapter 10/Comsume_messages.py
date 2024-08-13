import oci
import time

from base64 import b64decode

ociMessageEndpoint = "https://cell-1.streaming.us-ashburn-1.oci.oraclecloud.com"  
ociStreamOcid = "ocid1.stream.oc1.iad.amaaaaaafniq2aqa3fbh2psr6t3ywufzxfwtpwdkcs44a5vqf6tlbpxcozbq"  

config = oci.config.from_file()
stream_client = oci.streaming.StreamClient(config, service_endpoint=ociMessageEndpoint)

cursor_details=oci.streaming.models.CreateCursorDetails(partition=str(0),type="TRIM_HORIZON",offset=0)
cursor_response = stream_client.create_cursor(ociStreamOcid,cursor_details).data.value
get_response = stream_client.get_messages(ociStreamOcid, cursor_response, limit=10)
print(" Read {} messages".format(len(get_response.data)))
for message in get_response.data:
            if message.key is None:
                key = "Null"
            else:
                key = b64decode(message.key.encode()).decode()
            print("{}: {}".format(key,
                                  b64decode(message.value.encode()).decode()))