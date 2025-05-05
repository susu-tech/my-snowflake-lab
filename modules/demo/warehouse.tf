resource "snowflake_warehouse" "demo_wh" {
  name                                = "DEMO_WH2"
  comment                             = "Demo Warehouse"
  warehouse_size                      = "XSMALL"
  auto_suspend                        = 30
  auto_resume                         = true
  initially_suspended                 = true
  enable_query_acceleration           = false
  statement_queued_timeout_in_seconds = 300
  statement_timeout_in_seconds        = 600
  warehouse_type                      = "STANDARD"
}
