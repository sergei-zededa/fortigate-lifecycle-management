- name: Create VMs
  hosts: localhost
  collections:
    - fortinet.fortiflexvm

  tasks:

    - name: Include variables from a file
      include_vars:
        file: env_vars.yaml
        name: myenv

    - name: Create Virtual Machines
      fortinet.fortiflexvm.fortiflexvm_entitlements_vm_create:
        username: "{{ myenv.username }}"
        password: "{{ myenv.password }}"
        configId: 4818
        count: 30
        description: "mydescriptiontemplate"
        endDate: "2026-06-18T23:59:59"
        folderPath: "My Assets"
      register: result

    - name: Display response
      debug:
        var: result.entitlements
