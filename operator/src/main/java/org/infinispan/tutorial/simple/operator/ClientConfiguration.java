package org.infinispan.tutorial.simple.operator;

import org.infinispan.client.hotrod.configuration.ConfigurationBuilder;

class ClientConfiguration {

   private ClientConfiguration() {
   }

   static ConfigurationBuilder create(String svcDnsName) {
      final ConfigurationBuilder cfg = new ConfigurationBuilder();

      cfg
          .addServer()
          .host(svcDnsName)
          .port(11222);

      return cfg;
   }

}
