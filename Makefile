RABBIT_CODEGEN='https://github.com/rabbitmq/rabbitmq-codegen.git'
RABBIT_SERVER='https://github.com/rabbitmq/rabbitmq-server.git'
AMQP_CLIENT='https://github.com/rabbitmq/rabbitmq-erlang-client.git'
BUILDDIR=deps/rabbit_common
DISTDIR=$(BUILDDIR)/dist

all: 
	echo you must choice a target 'amqp_client' or 'rabbit_common'.

fetch:
	+rm -rf deps
	+mkdir -p deps
	git clone $(RABBIT_CODEGEN) deps/rabbitmq-codegen
	git clone $(RABBIT_SERVER) deps/rabbitmq-server
	git clone $(AMQP_CLIENT) $(BUILDDIR)

amqp_client: fetch
	(cd $(BUILDDIR); make)
	+rm -rf ebin
	+rm -rf include
	cp -Rp $(DISTDIR)/amqp_client-0.0.0/ebin ebin
	cp -Rp $(DISTDIR)/amqp_client-0.0.0/include include
	+rm -rf deps

rabbit_common: fetch
	(cd $(BUILDDIR); make)
	+rm -rf ebin
	+rm -rf include
	cp -Rp $(DISTDIR)/rabbit_common-0.0.0/ebin ebin
	cp -Rp $(DISTDIR)/rabbit_common-0.0.0/include include
	+rm -rf deps

clean:
	+rm -rf deps
	+rm -rf include
	+rm -rf ebin
	+rm .fetch .compile 
