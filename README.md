# binkd
Raspberry Pi docker image for Binkd

## Quick Start

This container image is available from the Docker Hub.

First write down the path to your binkd.conf file.  Then create an uplinks.txt containing each of the nodes you want to poll every hour - e.g.

21:1/100@fsxnet
21:2/100@fsxnet
etc...

Assuming that you have Docker installed, run the following command:

````bash
docker run -d \
    -v path_to/binkd.conf:/binkd/binkd.conf \
    -v path_to/uplinks.txt:/binkd/uplinks.txt \
    -v path_to_bbs_mail_dir:/mail \
    -p 54554:24554 \
    fransking/binkd-arm32v6|arm32v7 depending on your architecture
````


## License 

This project is licensed under the [BSD 2-Clause License](LICENSE).
