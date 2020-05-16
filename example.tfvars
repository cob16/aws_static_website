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
