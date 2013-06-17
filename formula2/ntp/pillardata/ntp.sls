##################################
##### Pillar Example For NTP #####
##################################

# Note grains['environment'] is a custom grain in this example
# Your method of determining what environment a server is in will vary

ntp:
  ### Assign NTP Servers Based On Environment ###
  # Internal NTP Servers Get Data From Outside #
  {% if grains['id'].startswith('nameofyourntpserver') %}
  ntpservers: ["0.us.pool.ntp.org","1.us.pool.ntp.org","2.us.pool.ntp.org","3.us.pool.ntp.org"]
  comment: ''

  # If This Is Production #
  {% if grains['environment'] == 'production' %}
  localnetworks: ["10.1.1.0", "10.1.2.0", "10.1.3.0"]
  # If Not, Must Be Dev #
  {% else %}
  localnetworks: ["10.1.4.0","10.1.5.0","10.1.6.0"]
  {% endif %}

  # Otherwise This Is Just An Internal Box
  {% else %}
  comment: '#'
  localnetworks: ["192.168.1.0"]

  # Assign Local Box NTP Server Based On Environment
  {% if grains['environment'] == 'production' %}
  ntpservers: ["10.1.1.20","10.1.1.21"]
  {% else %}
  ntpservers: ["10.1.4.20"]
  {% endif %}

  {% endif %}
