terraform {
  required_providers {
    oci = {
      source = "oracle/oci"
    }
  }
}

provider "oci" {
  region              = "us-sanjose-1"
}

resource "oci_core_vcn" "cna_vcn" {
  dns_label      = "cnavcn"
  cidr_block     = "172.16.0.0/20"
  compartment_id = var.compartment_id
  display_name   = "CNA_VCN"
}

resource "oci_core_subnet" "private_subnet" {
    cidr_block = "172.16.0.0/24"
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.cna_vcn.id
    display_name = "privatesubnet"
    dns_label = "privatesubnet"
    prohibit_internet_ingress = true
    prohibit_public_ip_on_vnic = true
    route_table_id = oci_core_vcn.cna_vcn.default_route_table_id
    security_list_ids = [oci_core_vcn.cna_vcn.default_security_list_id]
}

resource "oci_core_subnet" "public_subnet" {
    cidr_block = "172.16.1.0/24"
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.cna_vcn.id
    display_name = "publicsubnet"
    dns_label = "publicsubnet"
    prohibit_internet_ingress = false
    prohibit_public_ip_on_vnic = false
    route_table_id = oci_core_vcn.cna_vcn.default_route_table_id
    security_list_ids = [oci_core_vcn.cna_vcn.default_security_list_id]
}