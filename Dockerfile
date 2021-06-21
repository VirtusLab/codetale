FROM registry.gitlab.com/codetaleintegration/codetale-converter:0.1

LABEL "com.github.actions.name"="CodeTale Converter"
LABEL "com.github.actions.description"="Convert merged pull-request comments for integration with CodeTale plugin"
LABEL "com.github.actions.icon"="book-open"
LABEL "com.github.actions.color"="green"

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]