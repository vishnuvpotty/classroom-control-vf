class users::admins {
users::managed_user { 'VVP': }
users::managed_user { 'Hellouser':
group => 'staff',
}
users::managed_user { 'varun':
group => 'staff',
}
group { 'staff':
ensure => present,
}
}
