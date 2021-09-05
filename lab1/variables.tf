variable "int_port" {
    default = 3000

    validation {
        condition = var.int_port == 3000
        error_message = "The grafana port must be 3000."
    }
}

