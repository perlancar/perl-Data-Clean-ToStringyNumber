package Data::Clean::ToStringyNumber;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use parent qw(Data::Clean);

sub command_replace_with_stringy_number {
    require Scalar::Util::LooksLikeNumber;

    my ($self, $args) = @_;
    return '{{var}} = defined({{var}}) && Scalar::Util::LooksLikeNumber::looks_like_number({{var}}) > 36 ? "{{var}}" : {{var}}';
}

sub new {
    my ($class, %opts) = @_;
    $opts{""} //= ['replace_with_stringy_number'];
    $class->SUPER::new(%opts);
}

sub get_cleanser {
    my $class = shift;
    state $singleton = $class->new;
    $singleton;
}

1;
# ABSTRACT: Convert non-stringy numbers in data to stringy numbers

=for Pod::Coverage ^(new|command_.+)$

=head1 SYNOPSIS

 use Data::Clean::ToStringyNumber;
 my $cleanser = Data::Clean::ToStringyNumber->get_cleanser;
 my $data     = ["a", 1, "1.2", []];
 my $cleaned  = $cleanser->clean_in_place($data); # -> ["a", "1", "1.2", []]


=head1 DESCRIPTION

This class can convert non-stringy numbers in your data to stringy ones.


=head1 METHODS

=head2 CLASS->get_cleanser => $obj

Return a singleton instance.

=head2 $obj->clean_in_place($data) => $cleaned

Clean $data. Modify data in-place.

=head2 $obj->clone_and_clean($data) => $cleaned

Clean $data. Clone $data first.


=head1 SEE ALSO

L<Data::Clean::ToNonStringyNumber>

=cut
