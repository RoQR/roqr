require "graphql/client"
require "graphql/client/http"

module Fly
  class Client
    URL = "https://api.fly.io/graphql".freeze
    FLY_GRAPHQL_ACCESS_TOKEN = ENV.fetch("FLY_GRAPHQL_ACCESS_TOKEN", nil)
    class QueryError < StandardError; end

    HttpAdapter = ::GraphQL::Client::HTTP.new(URL) do
      def headers(_context)
        {
          "Authorization" => "Bearer #{FLY_GRAPHQL_ACCESS_TOKEN}"
        }
      end
    end

    Client = ::GraphQL::Client.new(
      schema: ::GraphQL::Client.load_schema(HttpAdapter),
      execute: HttpAdapter
    )

    GetIps = Client.parse <<-'GRAPHQL'
      query($appName: String!) {
	app(name: $appName) {
	    ipAddresses {
	      nodes {
	        address
	        id
	        type
	      }
	    }
	  }
	} 
    GRAPHQL

    GetCerts = Client.parse <<-'GRAPHQL'
		query($appName: String!) {
		  app(name: $appName) {
		    certificates {
		      nodes {
		        createdAt
		        hostname
		        clientStatus
		      }
		    }
		  }
		}
    GRAPHQL

    GetCert = Client.parse <<~'GRAPHQL'
      query($appName: String!, $hostname: String!) {
        app(name: $appName) {
          certificate(hostname: $hostname) {
            configured
            acmeDnsConfigured
            acmeAlpnConfigured
            certificateAuthority
            createdAt
            dnsProvider
            dnsValidationInstructions
            dnsValidationHostname
            dnsValidationTarget
            hostname
            id
            source
            clientStatus
            issued {
              nodes {
                type
                expiresAt
              }
            }
          }
        }
      }
    GRAPHQL

    CheckCert = Client.parse <<~'GRAPHQL'
      query($appName: String!, $hostname: String!) {
        app(name: $appName) {
          certificate(hostname: $hostname) {
              check
              configured
              acmeDnsConfigured
              acmeAlpnConfigured
              certificateAuthority
              createdAt
              dnsProvider
              dnsValidationInstructions
              dnsValidationHostname
              dnsValidationTarget
              hostname
              id
              source
              clientStatus
              issued {
                nodes {
                    type
                    expiresAt
                }
              }
          }
        }
      }
    GRAPHQL

    AddCert = Client.parse <<~'GRAPHQL'
      mutation($appId: ID!, $hostname: String!) {
          addCertificate(appId: $appId, hostname: $hostname) {
              certificate {
                  configured
                  acmeDnsConfigured
                  acmeAlpnConfigured
                  certificateAuthority
                  certificateRequestedAt
                  dnsProvider
                  dnsValidationInstructions
                  dnsValidationHostname
                  dnsValidationTarget
                  hostname
                  id
                  source
              }
          }
      }
    GRAPHQL

    DeleteCert = Client.parse <<~'GRAPHQL'
      mutation($appId: ID!, $hostname: String!) {
           deleteCertificate(appId: $appId, hostname: $hostname) {
               app {
                   name
               }
               certificate {
                   hostname
                   id
               }
           }
       }
    GRAPHQL

    def get_ips(application)
      response = Client.query(
        GetIps,
        variables: {
          appName: application
        }
      )
      raise QueryError, response.errors[:data].join(",") if response.errors.any?

      response.data.app.ip_addresses.nodes.map(&:to_h).to_a
    end

    def get_certs(application)
      response = Client.query(
        GetCerts,
        variables: {
          appName: application
        }
      )
      raise QueryError, response.errors[:data].join(",") if response.errors.any?

      results.data.app.certificates.nodes.map(&:to_h)
    end

    def get_cert(application, hostname)
      response = Client.query(
        GetCert,
        variables: {
          appName: application,
          hostname:
        }
      )
      raise QueryError, response.errors[:data].join(",") if response.errors.any?

      response.data.app.certificate.to_h
    end

    def check_cert(application, hostname)
      response = Client.query(
        CheckCert,
        variables: {
          appName: application,
          hostname:
        }
      )
      raise QueryError, response.errors[:data].join(",") if response.errors.any?

      response.data.app.certificate.to_h
    end

    def add_cert(application, hostname)
      response = Client.query(
        AddCert,
        variables: {
          appId: application,
          hostname:
        }
      )
      raise QueryError, response.errors[:data].join(",") if response.errors.any?

      response.data.add_certificate.certificate.to_h
    end

    def delete_cert(application, hostname)
      response = Client.query(
        DeleteCert,
        variables: {
          appId: application,
          hostname:
        }
      )

      raise QueryError, response.errors[:data].join(",") if response.errors.any?
    end
  end
end
