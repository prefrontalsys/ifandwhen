<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:atom="http://www.w3.org/2005/Atom">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html lang="en">
      <head>
        <title><xsl:value-of select="/atom:feed/atom:title"/> — RSS Feed</title>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <style>
          body {
            max-width: 680px;
            margin: 4rem auto;
            padding: 0 1.5rem;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            color: #1a1a18;
            background: #f5f2eb;
            line-height: 1.6;
          }
          h1 { font-size: 1.5rem; margin-bottom: 0.25rem; }
          .subtitle { color: #635850; margin-bottom: 2rem; }
          .note {
            background: #eeeae0;
            padding: 1rem 1.25rem;
            border-radius: 6px;
            margin-bottom: 2rem;
            font-size: 0.9rem;
            color: #635850;
          }
          .note code {
            background: #d8d4cc;
            padding: 0.15em 0.4em;
            border-radius: 3px;
            font-size: 0.85em;
          }
          .entry { border-top: 1px solid #c8c0b0; padding: 1.25rem 0; }
          .entry-title { font-size: 1.1rem; margin: 0 0 0.25rem; }
          .entry-title a { color: #b5341a; text-decoration: none; }
          .entry-title a:hover { text-decoration: underline; }
          .entry-date { font-size: 0.85rem; color: #635850; }
          .entry-summary { margin-top: 0.5rem; font-size: 0.95rem; }
        </style>
      </head>
      <body>
        <h1><xsl:value-of select="/atom:feed/atom:title"/></h1>
        <p class="subtitle"><xsl:value-of select="/atom:feed/atom:subtitle"/></p>
        <div class="note">
          This is an RSS feed. Copy this URL into your feed reader to subscribe:
          <br/>
          <code><xsl:value-of select="/atom:feed/atom:link[@rel='self']/@href"/></code>
        </div>
        <xsl:for-each select="/atom:feed/atom:entry">
          <div class="entry">
            <h2 class="entry-title">
              <a>
                <xsl:attribute name="href"><xsl:value-of select="atom:link/@href"/></xsl:attribute>
                <xsl:value-of select="atom:title"/>
              </a>
            </h2>
            <div class="entry-date"><xsl:value-of select="substring(atom:published, 1, 10)"/></div>
            <xsl:if test="atom:summary">
              <p class="entry-summary"><xsl:value-of select="atom:summary"/></p>
            </xsl:if>
          </div>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
