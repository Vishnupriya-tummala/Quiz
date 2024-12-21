
import re
from collections import Counter

log_file = '/var/log/apache2/access.log'

with open(log_file, 'r') as file:
    log_data = file.readlines()

pattern = r' 404 '
error_count = sum(1 for line in log_data if re.search(pattern, line))

pages = [line.split()[6] for line in log_data]
page_counts = Counter(pages)

print(f"Number of 404 errors: {error_count}")
print("Most requested pages:")
for page, count in page_counts.most_common(5):
    print(f"{page}: {count} requests")
