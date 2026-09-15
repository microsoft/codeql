private import codeql.iac.YAML
private import codeql.files.FileSystem

module Compose {
  /**
   * A Compose file node.
   */
  private class Node extends YamlNode {
    Node() {
      this.getFile().getBaseName() =
        [
          // Compose
          "compose.yml", "compose.yaml",
          // Docker
          "docker-compose.yml", "docker-compose.yaml",
          // Podman
          "podman-compose.yml", "podman-compose.yaml",
        ]
    }
  }

  /**
   * Docker / Podman Compose file.
   */
  class Document extends Node, YamlDocument, YamlMapping {
    /**
     * Returns the version of the Compose file.
     */
    string getApiVersion() {
      result = this.lookup("version").toString().regexpReplaceAll("('|\")", "")
    }

    /**
     * Returns the services defined in the Compose file.
     */
    Service getServices() { result = this.lookup("services").getAChildNode() }

    YamlValue getNetworks() { result = this.lookup("networks") }

    YamlValue getVolumes() { result = this.lookup("volumes") }

    YamlValue getSecrets() { result = this.lookup("secrets") }
  }

  /**
   * A service defined in a Compose file.
   */
  class Service extends YamlMapping {
    Document compose;

    /**
     * Compose Service
     */
    Service() { compose.lookup("services").getAChildNode() = this }

    /**
     * Returns the name of the service.
     */
    string getName() {
      result = yamlToString(this.lookup("container_name"))
      or
      exists(YamlMapping services, YamlValue key, YamlValue value |
        services = compose.lookup("services") and
        services.maps(key, value) and
        value = this and
        result = key.toString()
      )
    }

    string getImage() { result = yamlToString(this.lookup("image")) }

    YamlValue getBuild() { result = this.lookup("build") }

    YamlValue getEnvironment() { result = this.lookup("environment") }

    EnvironmentEntry getEnvironmentEntries() {
      result = this.lookup("environment").(YamlSequence).getAChild()
      or
      result = this.lookup("environment").(YamlMapping).getAChild()
    }

    YamlValue getSecrets() { result = this.lookup("secrets") }

    YamlValue getVolumes() { result = this.lookup("volumes") }

    YamlValue getCapAdd() { result = this.lookup("cap_add") }

    YamlValue getCapDrop() { result = this.lookup("cap_drop") }

    YamlValue getPrivileged() { result = this.lookup("privileged") }

    YamlValue getReadOnly() { result = this.lookup("read_only") }

    YamlValue getUser() { result = this.lookup("user") }

    YamlValue getPid() { result = this.lookup("pid") }

    YamlValue getNetworkMode() { result = this.lookup("network_mode") }

    YamlValue getDevices() { result = this.lookup("devices") }
  }

  class EnvironmentEntry extends YamlNode {
    EnvironmentEntry() {
      exists(Service service |
        service.lookup("environment").(YamlSequence).getAChildNode() = this
      )
      or
      exists(Service service |
        service.lookup("environment").(YamlMapping).getAChildNode() = this
      )
    }

    string getName() {
      result = this.(YamlString).getValue()
      or
      exists(YamlMapping environment, YamlValue key, YamlValue value |
        environment.getAChildNode() = this and
        environment.maps(key, value) and
        value = this and
        result = key.toString()
      )
    }

    YamlValue getValue() {
      result = this.(YamlMapping).lookup("value")
      or
      result = this.(YamlMapping).lookup("value_from")
      or
      result = this.(YamlMapping).lookup("value")
      or
      result = this
    }
  }
}
