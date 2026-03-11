- name: Update VM
  hosts: localhost
  collections:
    - fortinet.fortiflexvm

  tasks:

    - name: Include variables from a file
      include_vars:
        file: env_vars.yaml
        name: myenv

    - name: Update a Virtual Machine
      fortinet.fortiflexvm.fortiflexvm_entitlements_update:
        username: "{{ myenv.username }}"
        password: "{{ myenv.password }}"
        serialNumber: "fortigateserial"
        configId: 4818
        status: "ACTIVE"
      register: result

    - name: Display response
      debug:
        var: result.entitlements


