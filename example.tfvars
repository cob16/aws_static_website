namespace    = "myname-or-orgname"
website_name = "mycool.website.example.com"
email_mx_records = [
  "10 example.com",
  "20 example.com"
]
main_txt_records = [
  "v=spf1 include:_spf.example.com mx ~all",
]
extra_txt_records = {
  "_dmarc" : ["v=DMARC1; p=none; rua=mailto:mydmark@example.com"]
}
extra_a_records = {
  "subdomain" : ["192.0.2.0"]
}
extra_aaaa_records = {
  "subdomain" : ["2001:0db8::0001:0000"]
}
pagerduty_token         = "API KEY FOR PAGERDUTY https://support.pagerduty.com/docs/generating-api-keys#section-generating-a-general-access-rest-api-key"
alert_email             = "placeholder@example.com CHANGEME"
billing_alarm_threshold = 5
