import sys
from urllib.parse import urlparse, unquote, parse_qs

# Example for a typical "safe URL" in Outlook:
# https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Forgs%2Fbayer-int%2Fteams%2Fall&amp;data=04%7C01%7C%7C9fad40b4508345d259b408d9cea0309f%7Cfcb2b37b5da0466b9b830014b67a7c78%7C0%7C0%7C637768009664843912%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=rXw7hRiGRzuRiX5lkrF%2BxlRnuMlAsbbJtza4C9QT%2BJw%3D&amp;reserved=0
# which decodes to:
# https://github.com/orgs/bayer-int/teams/all

safeurl = sys.argv[1]
query = urlparse(safeurl).query
query_strings = parse_qs(query)
unsafeurl = query_strings["url"][0]
print(unsafeurl)
