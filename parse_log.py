import re
from prometheus_client import start_http_server, Counter
import time
log_format = r'(?P<remote_addr>\S+) - (?P<remote_user>\S+) \[(?P<timestamp>.*?)\] "(?P<request_method>\S+?) (?P<url>\S+?) HTTP/(?P<http_version>.*?)" (?P<status_code>\d+) (?P<response_size>\d+) "(?P<referrer>.*?)" "(?P<user_agent>.*?)"'

bytes_sent_counter = Counter(name="total_bytes_sent", documentation="NGINX total bytes sent", labelnames=["referer"])

if __name__ == "__main__":
    start_http_server(8193)
    with open("./access.log", 'r') as f:
        initial_position = f.tell()
    while True:
        with open("./access.log", "r") as f:
            f.seek(initial_position)
            for i in f:
                print(int(re.findall(log_format, i)[0][7]))
                print(re.findall(log_format, i)[0][8])
                bytes_sent_counter.labels(referer=re.findall(log_format, i)[0][8]).inc(amount=int(re.findall(log_format, i)[0][7]))
            initial_position = f.tell()
            time.sleep(5)
