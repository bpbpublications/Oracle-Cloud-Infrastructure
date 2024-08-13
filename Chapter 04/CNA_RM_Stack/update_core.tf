resource "oci_core_instance" "oci_instance_1" {
	availability_domain = "BbOk:US-ASHBURN-AD-1"
	compartment_id = var.compartment_ocid
	create_vnic_details {
		assign_ipv6ip = "false"
		assign_private_dns_record = "true"
		assign_public_ip = "false"
		subnet_id = oci_core_subnet.export_privatesubnet.id
	}
	display_name = "CNAPrivateInstance"
	instance_options {
		are_legacy_imds_endpoints_disabled = "false"
	}
	is_pv_encryption_in_transit_enabled = "true"
	metadata = {
    "ssh_authorized_keys" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsho6SQuXxUujIXTocTCGXtaBToUOBi"
	}
	shape = "VM.Standard.A1.Flex"
  shape_config {
    baseline_ocpu_utilization = ""
    memory_in_gbs             = "1"
    ocpus                     = "1"
    vcpus                     = "1"
  }
	source_details {
		source_id = "ocid1.image.oc1.iad.aaaaaaaamfhvgmej5jiwcqc3xprachdoc5yhwn4zwub5yok67d6m47vry6na"
		source_type = "image"
	}
}

resource "oci_core_instance" "oci_instance_2" {
	availability_domain = "BbOk:US-ASHBURN-AD-1"
	compartment_id = var.compartment_ocid
	create_vnic_details {
		assign_ipv6ip = "false"
		assign_private_dns_record = "true"
		assign_public_ip = "true"
		subnet_id = oci_core_subnet.export_publicsubnet.id
	}
	display_name = "CNAPublicInstance"
	instance_options {
		are_legacy_imds_endpoints_disabled = "false"
	}
	is_pv_encryption_in_transit_enabled = "true"
	metadata = {
    "ssh_authorized_keys" = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCsho6SQuXxUujIXTocTCGXtaBToUOBi"
	}
	shape = "VM.Standard.A1.Flex"
  shape_config {
    baseline_ocpu_utilization = ""
    memory_in_gbs             = "1"
    ocpus                     = "1"
    vcpus                     = "1"
  }
	source_details {
		source_id = "ocid1.image.oc1.iad.aaaaaaaamfhvgmej5jiwcqc3xprachdoc5yhwn4zwub5yok67d6m47vry6na"
		source_type = "image"
	}
}
