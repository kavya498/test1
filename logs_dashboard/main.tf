terraform {
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      version = "1.75.1"
    }
  }
}
variable "dashboard_root_folder" {
  default  = "root"
}
variable "dashboard_sub_folders" {
  default  = ["on-call"]
}
resource "ibm_logs_dashboard_folder" "logs_dashboard_folder" {
    instance_id = "cf2bd8a5-98c7-4d57-a2d4-ad35d0385d64"
  region      = "eu-de"
  name        = var.dashboard_root_folder
}
resource "ibm_logs_dashboard_folder" "logs_dashboard_subfolder" {
  for_each    = toset(var.dashboard_sub_folders)
    instance_id = "cf2bd8a5-98c7-4d57-a2d4-ad35d0385d64"
  region      = "eu-de"
  name        = each.value
  parent_id   = ibm_logs_dashboard_folder.logs_dashboard_folder.dashboard_folder_id
}
resource "ibm_logs_dashboard" "logs_dashboard_instance" {
instance_id = "cf2bd8a5-98c7-4d57-a2d4-ad35d0385d64"
  region      = "eu-de"
  name        = "test-graph-API-errors"
  description = "test-graph-API-errors"
  folder_id {
    value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
  }
  layout {
    sections {
      id {
        value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
      }
      rows {
        id {
          value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
        }
        appearance {
          height = 19
        }
        widgets {
          id {
            value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
          }
          title       = "Stage API Errors"
          description = "Stage API Errors Creation using terraform script"
          definition {
            line_chart {
              legend {
                is_visible     = true
                group_by_query = true
              }
              tooltip {
                show_labels = false
                type        = "all"
              }
              query_definitions {
                id             = ""
                color_scheme   = "classic"
                name           = "API Errors"
                is_visible     = true
                scale_type     = "linear"
                data_mode_type = "archive"
                unit           = "unspecified"
                resolution {
                  buckets_presented = 96
                }
                series_count_limit = 20
                query {
                  logs {
                    aggregations {
                      count {}
                    }
                    lucene_query {
                      value = "(coralogix.metadata.subsystemName:key-management-api AND coralogix.metadata.severity:Error)"
                    }
                  }
                }
              }
              query_definitions {
                id             = ""
                color_scheme   = "classic"
                name           = "API Healthchecks"
                is_visible     = true
                scale_type     = "linear"
                data_mode_type = "archive"
                resolution {
                  buckets_presented = 96
                }
                series_count_limit = 20
                query {
                  logs {
                    aggregations {
                      count {}
                    }
                    lucene_query {
                      value = "(coralogix.metadata.subsystemName:\"key-management-api\" AND message.request_uri:(\"/_version\" OR \"//_version\" OR \"/admin/v1/healthcheck\" OR \"/admin/v2/healthcheck\"))"
                    }
                  }
                }
              }
              query_definitions {
                id             = ""
                color_scheme   = "classic"
                name           = "API Warnings"
                is_visible     = true
                scale_type     = "linear"
                data_mode_type = "archive"
                resolution {
                  buckets_presented = 96
                }
                series_count_limit = 20
                query {
                  logs {
                    aggregations {
                      count {}
                    }
                    lucene_query {
                      value = "(coralogix.metadata.subsystemName:key-management-api AND coralogix.metadata.severity:Warning)"
                    }
                  }
                }
              }
              query_definitions {
                id             = ""
                color_scheme   = "classic"
                name           = "API Activity"
                is_visible     = true
                scale_type     = "linear"
                data_mode_type = "archive"
                resolution {
                  buckets_presented = 96
                }
                series_count_limit = 20
                query {
                  logs {
                    aggregations {
                      count {}
                    }
                    lucene_query {
                      value = "(coralogix.metadata.subsystemName:\"key-management-api\" AND NOT message.request_uri:(\"/_version\" OR \"//_version\" OR \"/admin/v1/healthcheck\" OR \"/admin/v2/healthcheck\"))"
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  relative_time_frame = "3600s"
}
resource "ibm_logs_dashboard" "logs_dashboard_instance1" {
    instance_id = "cf2bd8a5-98c7-4d57-a2d4-ad35d0385d64"
  region      = "eu-de"
  name        = "Test Dashboard"
  description = "Graphs generated using terraform scripts"
  folder_id {
    value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
  }
  layout {
    sections {
      id {
        value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
      }
      rows {
        id {
          value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
        }
        appearance {
          height = 19
        }
        widgets {
          id {
            value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
          }
          title       = "Stage API Errors"
          description = "Stage API Errors Creation using terraform script"
          definition {
            line_chart {
              legend {
                is_visible     = true
                group_by_query = true
              }
              tooltip {
                show_labels = false
                type        = "all"
              }
              query_definitions {
                id             = ""
                color_scheme   = "classic"
                name           = "API Errors"
                is_visible     = true
                scale_type     = "linear"
                data_mode_type = "archive"
                unit           = "unspecified"
                resolution {
                  buckets_presented = 96
                }
                series_count_limit = 20
                query {
                  logs {
                    aggregations {
                      count {}
                    }
                    lucene_query {
                      value = "(coralogix.metadata.subsystemName:key-management-api AND coralogix.metadata.severity:Error)"
                    }
                  }
                }
              }
              query_definitions {
                id             = ""
                color_scheme   = "classic"
                name           = "API Healthchecks"
                is_visible     = true
                scale_type     = "linear"
                data_mode_type = "archive"
                resolution {
                  buckets_presented = 96
                }
                series_count_limit = 20
                query {
                  logs {
                    aggregations {
                      count {}
                    }
                    lucene_query {
                      value = "(coralogix.metadata.subsystemName:\"key-management-api\" AND message.request_uri:(\"/_version\" OR \"//_version\" OR \"/admin/v1/healthcheck\" OR \"/admin/v2/healthcheck\"))"
                    }
                  }
                }
              }
              query_definitions {
                id             = ""
                color_scheme   = "classic"
                name           = "API Warnings"
                is_visible     = true
                scale_type     = "linear"
                data_mode_type = "archive"
                resolution {
                  buckets_presented = 96
                }
                series_count_limit = 20
                query {
                  logs {
                    aggregations {
                      count {}
                    }
                    lucene_query {
                      value = "(coralogix.metadata.subsystemName:key-management-api AND coralogix.metadata.severity:Warning)"
                    }
                  }
                }
              }
              query_definitions {
                id             = ""
                color_scheme   = "classic"
                name           = "API Activity"
                is_visible     = true
                scale_type     = "linear"
                data_mode_type = "archive"
                resolution {
                  buckets_presented = 96
                }
                series_count_limit = 20
                query {
                  logs {
                    aggregations {
                      count {}
                    }
                    lucene_query {
                      value = "(coralogix.metadata.subsystemName:\"key-management-api\" AND NOT message.request_uri:(\"/_version\" OR \"//_version\" OR \"/admin/v1/healthcheck\" OR \"/admin/v2/healthcheck\"))"
                    }
                  }
                }
              }
            }
          }
        }
      }
      rows {
        id {
          value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
        }
        appearance {
          height = 19
        }
        widgets {
          id {
            value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
          }
          title       = "IAM_REQUEST_DURATION_MS - Average"
          description = "IAM_REQUEST_DURATION_MS graph Creation using terraform script"
          definition {
            line_chart {
              legend {
                is_visible     = true
                group_by_query = true
              }
              tooltip {
                show_labels = false
                type        = "all"
              }
              query_definitions {
                id             = ""
                color_scheme   = "classic"
                name           = "API Errors"
                is_visible     = true
                scale_type     = "linear"
                data_mode_type = "archive"
                unit           = "unspecified"
                resolution {
                  buckets_presented = 96
                }
                series_count_limit = 20
                query {
                  logs {
                    aggregations {
                      average {
                        observation_field { keypath = ["message.iam_request_duration_ms"] }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      rows {
        id {
          value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
        }
        appearance {
          height = 19
        }
        widgets {
          id {
            value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
          }
          title       = "RESPONSE_TIME_MS - Count"
          description = "RESPONSE_TIME_MS - Count (with group_by)"
          definition {
            line_chart {
              legend {
                is_visible     = true
                group_by_query = true
              }
              tooltip {
                show_labels = false
                type        = "all"
              }
              query_definitions {
                id             = ""
                color_scheme   = "classic"
                name           = "API Errors"
                is_visible     = true
                scale_type     = "linear"
                data_mode_type = "archive"
                unit           = "unspecified"
                resolution {
                  buckets_presented = 96
                }
                series_count_limit = 20
                query {
                  logs {
                    group_by = ["message.response_time_ms"]
                    aggregations {
                      count {
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      rows {
        id {
          value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
        }
        appearance {
          height = 19
        }
        widgets {
          id {
            value = ibm_logs_dashboard_folder.logs_dashboard_subfolder["on-call"].dashboard_folder_id
          }
          title       = "RESPONSE_TIME_MS - Count (95 percentile)"
          description = "RESPONSE_TIME_MS - Count (95 percentile)"
          definition {
            line_chart {
              legend {
                is_visible     = true
                group_by_query = true
              }
              tooltip {
                show_labels = false
                type        = "all"
              }
              query_definitions {
                id             = ""
                color_scheme   = "classic"
                name           = "test"
                is_visible     = true
                scale_type     = "linear"
                data_mode_type = "archive"
                unit           = "unspecified"
                resolution {
                  buckets_presented = 96
                }
                series_count_limit = 20
                query {
                  logs {
                    aggregations {
                      percentile {
                        percent = 95.0
                        observation_field { keypath = ["message.response_time_ms"] }
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
  }
  relative_time_frame = "3600s"
}
