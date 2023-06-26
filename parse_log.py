import re
import os
from prometheus_client import start_http_server, Counter
import time

# Change directory to where contain code
abspath = os.path.abspath(__file__)
dname = os.path.dirname(abspath)
os.chdir(dname)

log_format = r'(?P<remote_addr>\S+) \[(?P<time_iso8601>.*?)\] (?P<http_host>.*) "(?P<request>.*)" (?P<status>\d+) (?P<body_bytes_sent>\d+) (?P<http_referer>.*) "(?P<http_user_agent>.*)"'

bytes_sent_counter = Counter(name="total_bytes_sent",
                             documentation="NGINX total bytes sent",
                             labelnames=["referer"])

if __name__ == "__main__":
    start_http_server(8193)
    with open("./access.log", 'r') as f:
        initial_position = f.tell()
    while True:
        with open("./access.log", "r") as f:
            f.seek(initial_position)
            for i in f:
                match = re.match(log_format, i)
                if match:
                    print(match.group("request"))
                    print(match.group("body_bytes_sent"))
                    print(match.group("http_host"))
                    bytes_sent_counter.labels(
                        referer=match.group("http_host")
                        ).inc(amount=int(match.group("body_bytes_sent")))
            initial_position = f.tell()
            time.sleep(5)
