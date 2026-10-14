"""Validate local HTML links and deployable assets without network requests."""
from html.parser import HTMLParser
from pathlib import Path
from urllib.parse import unquote, urlsplit

ROOT = Path(__file__).resolve().parents[1]
missing = set()

class Links(HTMLParser):
    def handle_starttag(self, tag, attrs):
        for name, value in attrs:
            if name not in ('href', 'src') or not value:
                continue
            url = urlsplit(value)
            if url.scheme or url.netloc or not url.path:
                continue
            target = ROOT / unquote(url.path).lstrip('/')
            if not target.exists():
                missing.add(value)

for page in ('index', 'about', 'clients', 'contact', 'services', 'team'):
    path = ROOT / f'{page}.html'
    assert path.is_file() and path.stat().st_size, f'Missing page: {path.name}'
    Links().feed(path.read_text(encoding='utf-8'))
for folder in ('css', 'js', 'images'):
    assert (ROOT / folder).is_dir(), f'Missing assets: {folder}'
assert not missing, f'Missing local links: {sorted(missing)}'
print('Six website pages and local asset references validated.')
