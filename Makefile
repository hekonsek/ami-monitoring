VERSION=0.3.0

build:
	packer build ami-monitoring.json

snapshot:
	./snapshot.sh