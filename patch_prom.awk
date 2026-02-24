/scrape_configs:/ {
    print $0
    print "  - job_name: 'nginx-web-app'"
    print "    static_configs:"
    print "      - targets: ['web-app-svc.default.svc.cluster.local:9113']"
    next
}
{ print $0 }
