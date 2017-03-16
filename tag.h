#ifndef TAG_H
#define TAG_H

#include "object.h"

extern const char *tag_type;

struct tag {
	struct object object;
	struct object *tagged;
	char *tag;
	size_t date;
};

extern struct tag *lookup_tag(const unsigned char *sha1);
extern int parse_tag_buffer(struct tag *item, const void *data, size_t size);
extern int parse_tag(struct tag *item);
extern struct object *deref_tag(struct object *, const char *, int);
extern struct object *deref_tag_noverify(struct object *);
extern int gpg_verify_tag(const unsigned char *sha1,
		const char *name_to_report, unsigned flags);

#endif /* TAG_H */
