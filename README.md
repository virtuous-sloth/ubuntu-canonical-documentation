# Analyze Ubuntu and Canonical documentation structure

## Introduction

For those people for whom knowing the structure underlying something helps them
find information, such as myself, I want to collect and analyze what structure
I can find.

From the highest level, let's start with the primary entry points for
documentation, these three URLs (note that for this document I'll leave off
the `https://`.

- `wiki.ubuntu.com/`
- `wiki.canonical.co1m/`
- `docs.ubuntu.com/`

The first two are obvisously wikis and designed to stand on their own as both
the source and presentation of documentation, but will also likely have links
to other sources/locations. The last is a regular web page that functions as a
landing page pointing to a collection of documentation web sites. The former
wikis have a long history dataing back to the beginning of Ubuntu and Canonical
while the latter is part of a concerted effort apply a more rigorous practice
to documentation at Canonical. Since the latter is forward-looking we'll
start there.

## docs.ubuntu.com

[This script](docs.ubuntu.com_table.sh):
```bash
#!/usr/bin/bash

name=$(basename "$0" | sed -e 's/\.sh$//')

curl --silent https://docs.ubuntu.com/ \
	| htmlparser 'a[class="p-link"] json{}' \
	| jq -r '["Doc Site", "URL"], (.[] | [.text, .href]) | @csv' \
	| tr '"' "\`" \
	| csvlook > "$name".md
```
fetches the `docs.ubuntu.com/` page and
processes out the documentation site links into a
[markdown table](docs.ubuntu.com_table.md):

| `Doc Site`           | `URL`                                          |
| -------------------- | ---------------------------------------------- |
| `MAAS`               | `https://maas.io/docs`                         |
| `Juju`               | `https://jaas.ai/docs`                         |
| `Snapcraft`          | `https://snapcraft.io/docs`                    |
| `LXD`                | `https://linuxcontainers.org/lxd/docs/master/` |
| `Landscape`          | `https://ubuntu.com/landscape/docs`            |
| `Snap Store Proxy`   | `/snap-store-proxy/en`                         |
| `Mir`                | `https://mir-server.io/doc/`                   |
| `Multipass`          | `https://multipass.run/docs`                   |
| `Cloud-init`         | `https://cloudinit.readthedocs.io/en/latest/`  |
| `Dqlite`             | `https://dqlite.io/docs/`                      |
| `MicroK8s`           | `https://microk8s.io/docs`                     |
| `Charmed Kubernetes` | `https://ubuntu.com/kubernetes/docs`           |
| `Netplan`            | `https://netplan.io/reference`                 |
| `Charmed OpenStack`  | `https://ubuntu.com/openstack/docs`            |
| `MicroStack`         | `https://microstack.run/docs`                  |
| `Desktop`            | `https://help.ubuntu.com/stable/ubuntu-help`   |
| `Server`             | `https://ubuntu.com/server/docs`               |
| `Core`               | `https://docs.ubuntu.com/core/en/`             |

## ubuntu.com/server/docs

Let's take a dive into `ubuntu.com/server/docs`. If you load the page and look
at the bottom

[This script](ubuntu.com-server-docs_table.sh):
```bash
#!/usr/bin/bash

name=$(basename "$0" | sed -e 's/\.sh$//')
url=$(echo $name | sed -e 's/_.*//' | tr - /)

curl --silent "https://$url" \
	| htmlparser 'json{}' \
	| jq '.. | objects | select(.text == "Help improve this document in the forum") | .href' \
	| tr '"' "\`" \
	> "$name".md
```
fetches the URL of the link to what turns out to be to source for this page:
`https://discourse.ubuntu.com/t/ubuntu-server-documentation/11322`
Of course, the web page for the discourse forum post is note entirely the
source, rather the source for the body of the posting is effectively the source
for the documentation web page, written in markdown, up until the this comment:
`<!-- Metadata for discourse module -->`
What follows that comment are two sections headed
```
## Navigation

[details=Navigation]
| Level | Path | Navlink |
```
and
```
# Redirects

[details=Mapping table]
| Path | Location |
```
respectively. The comment hints that document serves two purposes:
- providing the body text for the default page of `ubuntu.com/server/docs`
- providing the navigation and redirect metadata for the menu for the same
  section of the web site
```
00       1         2         3         4         5         6         7         8
12345678901234567890123456789012345678901234567890123456789012345678901234567890
```
