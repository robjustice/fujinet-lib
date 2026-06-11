#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include "fujinet-fuji.h"
#include "fujinet-fuji-cbm.h"

bool fuji_set_host_prefix(uint8_t hs, char *prefix)
{
  uint8_t *pl;
  uint16_t pl_len;
  bool is_success;

  pl_len = strlen(prefix) + 3 + 1;
  pl = malloc(pl_len);
  if (pl == NULL) {
    status_error(ERROR_MALLOC_FAILED, FUJICMD_SET_HOST_PREFIX);
    return false;
  }

  pl[0] = hs;
  strcpy((char *) &pl[1], prefix);
  pl[pl_len - 1] = '\0';

  is_success = open_close_data(FUJICMD_SET_HOST_PREFIX, true, pl_len, pl);
  free(pl);
  return is_success;
}
