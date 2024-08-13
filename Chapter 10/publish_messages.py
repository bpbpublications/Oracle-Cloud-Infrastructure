import oci  
  
from base64 import b64encode  
  
ociMessageEndpoint = "https://cell-1.streaming.us-ashburn-1.oci.oraclecloud.com"  
ociStreamOcid = "ocid1.stream.oc1.iad.amaaaaaafniq2aqa3fbh2psr6t3ywufzxfwtpwdkcs44a5vqf6tlbpxcozbq"  

config = oci.config.from_file()
stream_client = oci.streaming.StreamClient(config, service_endpoint=ociMessageEndpoint)

message_list = []
for i in range(5):
    key = "Key" + str(i)
    value = "Test Message: " + str(i)
    encoded_key = b64encode(key.encode()).decode()
    encoded_value = b64encode(value.encode()).decode()
    message_list.append(oci.streaming.models.PutMessagesDetailsEntry(key=encoded_key, value=encoded_value))

messages = oci.streaming.models.PutMessagesDetails(messages=message_list)
put_message_result = stream_client.put_messages(ociStreamOcid, messages)

for entry in put_message_result.data.entries:
      if entry.error:
          print("Error ({}) : {}".format(entry.error, entry.error_message))
      else:
          print("Published message to partition {} , offset {}".format(entry.partition, entry.offset))
